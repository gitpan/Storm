package Storm::Role::Query::HasWhereClause;
use Moose::Role;
use MooseX::Method::Signatures;
use MooseX::Types::Moose qw( ArrayRef HashRef );

use Storm::SQL::Literal;
use Storm::SQL::Placeholder;
use Storm::SQL::Fragment::Where::Boolean;
use Storm::SQL::Fragment::Where::Comparison;
use Storm::SQL::Fragment::Where::SubgroupStart;
use Storm::SQL::Fragment::Where::SubgroupEnd;

with 'Storm::Role::Query::CanParseUserArgs';
with 'Storm::Role::Query::HasAttributeMap';
with 'Storm::Role::Query::HasSQLFunctions';

has '_where' => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [] },
    traits => [qw( Array )],
    handles => {
        '_add_where_element' => 'push',
        'where_clause_elements' => 'elements',
        '_has_no_where_elements' => 'is_empty',
        '_get_where_element' => 'get',
    }, 
);

has '_link' => (
    is => 'bare',
    isa => HashRef,
    default => sub { { } },
    traits  => [qw( Hash )],
    handles => {
        '_set_linked' => 'set',
        '_has_link' => 'exists',
    }    
);


sub where {
    my $self = shift;
    
    # if it is a single argument, it is a boolean (and,or) operator or subgroup (parenthesis)
    if (@_ == 1) {
        my $operator = $_[0];
        
        # do subgroup start
        if ($operator eq '(') {
            my $element = Storm::SQL::Fragment::Where::SubgroupStart->new;
            $self->_add_and_if_needed;
            $self->_add_where_element($element);
        }
        # do subroup end
        elsif ($operator eq ')') {
            my $element = Storm::SQL::Fragment::Where::SubgroupEnd->new;
            $self->_add_where_element($element);
        }
        # otherwise pass on assuming it is a boolean operator
        else {           
            my $element = Storm::SQL::Fragment::Where::Boolean->new($operator);
            $self->_add_where_element($element);
        }
    }
    # otherwise it is a comparison
    else {
        my ($arg1, $operator, @args) = @_;
        
        # perform substitution on arguments
        ( $arg1, @args ) = $self->args_to_sql_objects( $arg1, @args );    
        
        # create the comparison
        my $element = Storm::SQL::Fragment::Where::Comparison->new($arg1, $operator, @args);
        $self->_add_and_if_needed;
        $self->_add_where_element($element);
    }

    return $self;
}

method and ( @args ) {
    $self->where( @args );
}

method or ( @args ) {
    $self->where( 'or' );
    $self->where( @_ );
}

method _link ( $attr, $class ) {
    my $right_col = $class->meta->primary_key->column;
    
    if ( ! $self->_has_link( $attr->name ) ) {
        # create the comparison
        my $element = Storm::SQL::Fragment::Where::Comparison->new($attr->column, '=', $right_col);
        $self->_add_and_if_needed;
        $self->_add_where_element($element);
        $self->_set_linked( $attr->name, 1 );
    }
}


method _where_clause ( $skip_where? ) {
    return if $self->_has_no_where_elements;
    
    my $sql  = '';
    $sql .= 'WHERE ' unless $skip_where;
    $sql .= join q[ ], map { $_->sql } $self->where_clause_elements;
    
    return $sql;
}

method _add_and_if_needed ( ) {    
    # no and needed for the first where clause
    return if ! $self->_get_where_element( -1 );
    
    # last element
    my $last = $self->_get_where_element( -1 );
    
    # no and after  AND, OR, NOT, XOR
    return if $last->isa('Storm::SQL::Fragment::Where::Boolean');
    
    # no and after opening parens
    return if $last->isa('Storm::SQL::Fragment::Where::SubgroupStart');

    $self->where('and');
}



no Moose::Role;
1;

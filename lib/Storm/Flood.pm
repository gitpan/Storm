package Storm::Flood;
{
  $Storm::Flood::VERSION = '0.18';
}

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

use Storm::Types qw(
Storm
);


has 'storm' => (
    is => 'rw',
    isa => Storm,
    required => 1,
    weak_ref => 1,
);

has 'plan' => (
    is => 'rw',
);


sub fill {
    my ( $self, $class, $plan ) = @_;
    
    # for each attribute, that serializes data
    
    # determine the type
    
    # fill the data
}
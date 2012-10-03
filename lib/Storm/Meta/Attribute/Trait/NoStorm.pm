package Storm::Meta::Attribute::Trait::NoStorm;
{
  $Storm::Meta::Attribute::Trait::NoStorm::VERSION = '0.19';
}
use Moose::Role;

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
  
    $options->{column} = undef;  
};

package Moose::Meta::Attribute::Custom::Trait::NoStorm;
{
  $Moose::Meta::Attribute::Custom::Trait::NoStorm::VERSION = '0.19';
}
sub register_implementation { 'Storm::Meta::Attribute::Trait::NoStorm' };
1;

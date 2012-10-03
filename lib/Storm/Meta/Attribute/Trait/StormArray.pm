package Storm::Meta::Attribute::Trait::StormArray;
{
  $Storm::Meta::Attribute::Trait::StormArray::VERSION = '0.19';
}
use Moose::Role;



package Moose::Meta::Attribute::Custom::Trait::StormArray;
{
  $Moose::Meta::Attribute::Custom::Trait::StormArray::VERSION = '0.19';
}
sub register_implementation { 'Storm::Meta::Attribute::Trait::StormArray' };
1;

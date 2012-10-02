package Storm::Meta::Attribute::Trait::PrimaryKey;
{
  $Storm::Meta::Attribute::Trait::PrimaryKey::VERSION = '0.18';
}
use Moose::Role;



package Moose::Meta::Attribute::Custom::Trait::PrimaryKey;
{
  $Moose::Meta::Attribute::Custom::Trait::PrimaryKey::VERSION = '0.18';
}
sub register_implementation { 'Storm::Meta::Attribute::Trait::PrimaryKey' };
1;

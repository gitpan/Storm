package Storm::SQL::Fragment::Where::SubgroupStart;
{
  $Storm::SQL::Fragment::Where::SubgroupStart::VERSION = '0.18';
}
use Moose;



sub sql { return '(' };



no Moose;
__PACKAGE__->meta()->make_immutable();
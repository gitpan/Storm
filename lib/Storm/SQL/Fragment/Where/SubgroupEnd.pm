package Storm::SQL::Fragment::Where::SubgroupEnd;
{
  $Storm::SQL::Fragment::Where::SubgroupEnd::VERSION = '0.19';
}
use Moose;



sub sql { return ')' };



no Moose;
__PACKAGE__->meta()->make_immutable();

1;


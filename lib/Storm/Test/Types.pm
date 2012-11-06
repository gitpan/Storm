package Storm::Test::Types;
{
  $Storm::Test::Types::VERSION = '0.200';
}

use MooseX::Types -declare => [qw(
    DateTime
)];

class_type DateTime,
    { class => 'DateTime' };

1;

package Storm::Test::Types;
{
  $Storm::Test::Types::VERSION = '0.19';
}

use MooseX::Types -declare => [qw(
    DateTime
)];

class_type DateTime,
    { class => 'DateTime' };

1;

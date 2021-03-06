use strict;
use warnings;
package HTML::Widget::Plugin::Checkbox;
# ABSTRACT: it's either [ ] or [x]

use parent 'HTML::Widget::Plugin';

=head1 SYNOPSIS

  $widget_factory->checkbox({
    id      => 'checkbox-id',    # also used as default for control name
    value   => 'checkbox-value', # -not- the "am I checked?" setting
    checked => $true_or_false,
  });

=head1 DESCRIPTION

This plugin provides a widget for boolean checkbox widgets.

=cut

use HTML::Element;

=head1 METHODS

=head2 C< provided_widgets >

This plugin provides the following widgets: checkbox

=cut

sub provided_widgets { qw(checkbox) }

=head2 C< checkbox >

This method returns a checkbox widget.

In addition to the generic L<HTML::Widget::Plugin> attributes, the following
are valid arguments:

=over

=item checked

This is the widget's initial state.  If true, the checkbox is checked.
Otherwise, it is not.

=item value

This is the value for the checkbox, not to be confused with whether or not it
is checked.

=back

=cut

sub _attribute_args { qw(checked disabled value) }
sub _boolean_args   { qw(checked disabled) }

sub checkbox {
  my ($self, $factory, $arg) = @_;

  $arg->{attr}{type} = 'checkbox';

  $arg->{attr}{name} = $arg->{attr}{id} if not defined $arg->{attr}{name};

  my $widget = HTML::Element->new('input');

  $widget->attr($_ => $arg->{attr}{$_}) for keys %{ $arg->{attr} };
  return $widget->as_XML;
}

1;


use strict;
use warnings;

package HTML::Widget::Plugin::Checkbox;
use base qw(HTML::Widget::Plugin);

=head1 NAME

HTML::Widget::Plugin::Checkbox - it's either [ ] or [x]

=head1 VERSION

version 0.01

 $Id$

=cut

our $VERSION = '0.01';

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

=item value

This is the widget's initial value.  If true, the checkbox is checked.
Otherwise, it is not.

=back

=cut

sub _attribute_args { qw(value) }

sub checkbox {
  my $self = shift;
  my $arg  = __PACKAGE__->rewrite_arg(shift);

  my $value = delete $arg->{attr}{value};
  $arg->{attr}{checked} = "checked" if $value;
  $arg->{attr}{type} = "checkbox";

  my $widget = HTML::Element->new('input');

  $widget->attr($_ => $arg->{attr}{$_}) for keys %{ $arg->{attr} };
  return $widget->as_HTML;
}

=head1 AUTHOR

Ricardo SIGNES <C<rjbs @ cpan.org>>

=head1 COPYRIGHT

Copyright (C) 2005, Ricardo SIGNES.  This is free software, released under the
same terms as perl itself.

=cut

1;

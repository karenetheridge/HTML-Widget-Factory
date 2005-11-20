
use strict;
use warnings;

package HTML::Widget::Plugin::Password;
use base qw(HTML::Widget::Plugin::Input);

=head1 NAME

HTML::Widget::Plugin::Password - for SECRET input

=head1 VERSION

version 0.01

 $Id$

=cut

our $VERSION = '0.01';

=head1 DESCRIPTION

This plugin provides a widget for password-entry inputs.

=cut

use HTML::Element;

=head1 METHODS

=head2 C< provided_widgets >

This plugin provides the following widgets: password

=cut

sub provided_widgets { qw(password) }

=head2 C< password >

This method returns a password-entry widget.

In addition to the generic L<HTML::Widget::Plugin> attributes, the following
are valid arguments:

=over

=item value

This is the widget's initial value.  The value is eaten and displayed as a
series of spaces, if the value is defined.

=back

=cut

sub password {
  my $self    = shift;
  my $factory = shift;
  my $arg     = $self->rewrite_arg(shift);

  return $self->build($factory, $arg);
}

sub rewrite_arg {
  my ($self, $arg) = @_;

  $arg = $self->SUPER::rewrite_arg($arg);

  $arg->{attr}{type} = "password";

  $arg->{attr}{value} &&= "        ";

  return $arg;
}

=head1 AUTHOR

Ricardo SIGNES <C<rjbs @ cpan.org>>

=head1 COPYRIGHT

Copyright (C) 2005, Ricardo SIGNES.  This is free software, released under the
same terms as perl itself.

=cut

1;

use strict;
use warnings;

package HTML::Widget::Plugin::Multiselect;
use base qw(HTML::Widget::Plugin::Select);

=head1 NAME

HTML::Widget::Plugin::Multiselect - widget for multiple selections from a list

=head1 VERSION

version 0.01

 $Id$

=cut

our $VERSION = '0.01';

=head1 DESCRIPTION

This plugin provides a select-from-list widget that allows the selection of
multiple elements.

=cut

use HTML::Element;

=head1 METHODS

=head2 C< provided_widgets >

This plugin provides the following widgets: multiselect

=cut

sub provided_widgets { qw(multiselect) }

=head2 C< multiselect >

This method returns a multiple-selection-from-list widget.  Yup.

In addition to the generic L<HTML::Widget::Plugin> attributes and the
L<HTML::Widget::Plugin::Select> attributes, the following are valid arguments:

=over

=item size

This is the number of elements that should be visible in the widget.

=back

=cut

sub _attribute_args { qw(size) }

sub multiselect {
  my $self    = shift;
  my $factory = shift;
  my $arg = $self->rewrite_arg(shift);

  $arg->{attr}{multiple} = 'multiple';

  if ($arg->{values}) {
    $arg->{value} = delete $arg->{values};
  }

  $self->build($factory, $arg);
}

sub make_option {
  my ($self, $factory, $value, $name, $arg) = @_;

  my $option = HTML::Element->new('option', value => $value);
     $option->push_content($name);
     $option->attr(selected => 'selected')
       if $arg->{value} and grep { $_ eq $value } @{ $arg->{value} };

  return $option;
}

=head2 C< validate_value >

This method checks whether the given value option is valid.  It throws an
exception if the given values are not all in the list of options.

=cut

sub validate_value {
  my ($class, $values, $options) = @_;

  $values = [ $values ] unless ref $values;

  for my $value (@$values) {
    my $matches = grep { $value eq $_ } map { ref $_ ? $_->[0] : $_ } @$options;
    Carp::croak "provided value not in given options" unless $matches;
  }
}




=head1 AUTHOR

Ricardo SIGNES <C<rjbs @ cpan.org>>

=head1 COPYRIGHT

Copyright (C) 2005, Ricardo SIGNES.  This is free software, released under the
same terms as perl itself.

=cut

1;
#!/usr/local/bin/perl
# ex:tw=80
package Convert::TimeUnits;
# This module contains no symbol table trickery because the author doesn't know
# how to do such things.

use 5.006;
use strict;
use warnings;

use Carp;

use Exporter ();
our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

$VERSION = 0.1;
@ISA = qw(Exporter);
@EXPORT = qw( );
@EXPORT_OK = qw(&seconds_to_years &seconds_to_weeks &seconds_to_days 
		&seconds_to_hours &seconds_to_minutes &minutes_to_years 
		&minutes_to_weeks &minutes_to_days &minutes_to_hours 
		&minutes_to_seconds &hours_to_years &hours_to_weeks
	       	&hours_to_days &hours_to_minutes &hours_to_seconds
	       	&days_to_years &days_to_weeks &days_to_hours &days_to_minutes 
		&days_to_seconds &weeks_to_years &weeks_to_days &weeks_to_hours 
		&weeks_to_minutes &weeks_to_seconds &years_to_days 
		&years_to_hours &years_to_minutes &years_to_seconds);

my @items = qw(seconds minutes hours days weeks years);
sub new
{
	my $invocant = shift;
	my $class = ref($invocant) || $invocant;
	my %units = @_;
	$units{$_} ||= 0 for(@items);
	my $self = \%units;
	return bless $self, $class;
}

sub get
{
	my $self = shift;
	my $item = shift;
	croak "get() is an object method and must be used that way" 
		unless(ref($self) && defined($item));
	croak "Please read the documentation for how to use get()"
		unless(grep { /^$item$/ } @items);
	if(!exists($self->{$item}))
	{
		croak <<DEATH;
Something terrible happened (the $item key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
	}
	$self->{$item};
}

sub set
{
	my $self = shift;
	my $item = shift;
	my $newval = shift;
	croak "set() is an object method and must be used that way"
		unless(ref($self) && defined($item));
	croak "Please read the documentation for how to use set()"
		unless(grep { /^$item$/ } @items);
	if(!(defined $newval) || $newval =~ /\D/ || $newval < 0)
	{
		croak "set() must be called with an item to set and " 
		. "a positive numeric argument";
	}
	if(!exists($self->{$item}))
	{
		croak <<DEATH;
Something terrible happened (the $item key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
	}
	$self->{$item} = $newval;
}

sub calc_seconds
{
	my $self = shift;
	croak "calc_seconds() is an object method and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $seconds = 0;
	$seconds += $self->{'years'} * 31556926;
	$seconds += $self->{'weeks'} * 604800;
	$seconds += $self->{'days'} * 86400;
	$seconds += $self->{'hours'} * 3600;
	$seconds += $self->{'minutes'} * 60;
	$seconds += $self->{'seconds'};
	$seconds;
}

sub calc_minutes
{
	my $self = shift;
	croak "calc_minutes() is an object method and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $minutes = 0;
	$minutes += $self->{'years'} * 525948.77;
	$minutes += $self->{'weeks'} * 10080;
	$minutes += $self->{'days'} * 1440;
	$minutes += $self->{'hours'} * 60;
	$minutes += $self->{'minutes'};
	$minutes += $self->{'seconds'} / 60;
	$minutes;
}

sub calc_hours
{
	my $self = shift;
	croak "calc_hours() is an object method and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $hours = 0;
	$hours += $self->{'years'} * 8765.8128;
	$hours += $self->{'weeks'} * 168;
	$hours += $self->{'days'} * 24;
	$hours += $self->{'hours'};
	$hours += $self->{'minutes'} / 60;
	$hours += $self->{'seconds'} / 3600;
	$hours;
}

sub calc_days
{
	my $self = shift;
	croak "calc_days() is an object method and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $days = 0;
	$days += $self->{'years'} * 365.2422;
	$days += $self->{'weeks'} * 7;
	$days += $self->{'days'};
	$days += $self->{'hours'} / 24;
	$days += $self->{'minutes'} / 1440;
	$days += $self->{'seconds'} / 86400;
	$days;
}

sub calc_weeks
{
	my $self = shift;
	croak "calc_weeks() is an object and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $weeks = 0;
	$weeks += $self->{'years'} * 52.177457;
	$weeks += $self->{'days'} * (1/7);
	$weeks += $self->{'hours'} * (1/168);
	$weeks += $self->{'minutes'} * (1/10080);
	$weeks += $self->{'seconds'} * (1/604800);
	$weeks;
	
}

sub calc_years
{
	my $self = shift;
	croak "calc_years() is an object method and must be used that way"
		unless(ref($self));
	for(@items)
	{
		if(!exists($self->{$_}))
		{
			croak <<DEATH;
Something terrible happened (the $_ key is gone)! Please email
apeiron\@comcast.net with your code.
DEATH
		}
	}
	my $years = 0;
	$years += $self->{'years'};
	$years += $self->{'weeks'} * (1/52.177457);
	$years += $self->{'days'} * (1/365.2422);
	$years += $self->{'hours'} * (1/8765.8128);
	$years += $self->{'minutes'} * (1/525948.77);
	$years += $self->{'seconds'} * (1/31556926);
}

sub seconds_to_years
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/31556926);
}

sub seconds_to_weeks
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/604800);
}

sub seconds_to_days
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/86400);
}

sub seconds_to_hours
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/3600);
}

sub seconds_to_minutes
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/60);
}

sub minutes_to_years
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/525948.77);
}

sub minutes_to_weeks
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if (!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/10080);
}

sub minutes_to_days
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/525948.77);
}

sub minutes_to_hours 
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/60);
}

sub minutes_to_seconds
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 60;
}

sub hours_to_years
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/8765.8128);
}

sub hours_to_weeks
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/168);
}

sub hours_to_days
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/24);
}

sub hours_to_minutes
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 60;
}

sub hours_to_seconds
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 3600;
}

sub days_to_years
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/365.2422);
}

sub days_to_weeks
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/7);
}

sub days_to_hours
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 24;
}

sub days_to_minutes
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 1440;
}

sub days_to_seconds
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 86400;
}

sub weeks_to_years
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * (1/52.177457);
}

sub weeks_to_days
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 7;
}

sub weeks_to_hours
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 168;
}

sub weeks_to_minutes
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 10080;
}

sub weeks_to_seconds
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 604800;
}

sub years_to_weeks
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 52.177457;
}

sub years_to_days
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 365.2422;
}

sub years_to_hours
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 8765.8128;
}

sub years_to_minutes
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 525948.77;
}

sub years_to_seconds
{
	my $arg = shift;
	croak "This is a class (static) method. Please use it as such."
		if ref($arg);
	croak "This class method must be called with a single positive numeric argument."
		if(!defined($arg) || $arg =~ /\D/ || $arg < 0);
	$arg * 31556926;
}
1;
__END__

=head1 NAME

Convert::TimeUnits - Perl module for converting between various units of time.

=head1 SYNOPSIS

  # Functional interface
  use Convert::TimeUnits qw(years_to_seconds days_to_minutes);
  my $seconds = years_to_seconds(3);
  my $days = days_to_minutes(1);

  # Object-oriented interface
  use Convert::TimeUnits;
  my $conv = new Convert::TimeUnits # all fields default to 0.
  (
    seconds	=> 0,
    minutes	=> 0,
    hours	=> 0,
    days	=> 5,
    weeks	=> 5,
    years	=> 0
  );
  my $seconds = $conv->get('seconds');
  $conv->set('days', 0);
  print $conv->calc_minutes(); # print total number of minutes for each field

=head1 DESCRIPTION

Convert::TimeUnits is a Perl module that simplifies the task of converting one
amount of time to its equivalent value as expressed by another unit. Negative
values are not permitted. All units referenced within the module whether as part
of the object returned by new() or as function names are plural. All methods
(object and class) take integer or floating point arguments and return the
appropriate numeric format. It is the user's responsibility to use sprintf()
and other date / time modules to format the results. All operations are limited
in precision first by the definitions in the code and second by Perl's numeric
data types.

For simple unit-to-unit conversions, the functional interface provides the 
greatest simplicity and import control. Simply import the required functions and
use them as part of the current package.

For a more detailed presentation of conversion information, the object-oriented
interface provides two accessor methods, get() and set(). The first argument to
each is the field to access, and the second argument to set() is the value to
set. Values which would cause a regrouping (e.g., seconds > 60) are permitted,
and are the main point of this module.

=head2 OBJECT-ORIENTED INTERFACE

=over 4

new()

=over 4

new() instantiates a Convert::TimeUnits object. The following fields are valid: 
seconds minutes hours days years weeks .

=back

get()

=over 4

get() returns the requested item. The fields which are valid for new() are also
valid for get().

=back

set()

=over 4

set() defines a value for a field. It takes two arguments: the field to set, and
a numeric value to which to set said field.

=back

calc_() methods

=over 4

All of the calc_() methods do not take arguments. There is a calc_() method for
each field of a Convert::TimeUnits object (thus calc_seconds(), calc_minutes(),
etc.). Each calc_() method converts all other fields to their equivalent values 
in the target unit, tallies the results of all of those calculations, and 
returns that sum. Note that invoking a calc_() method includes the requested 
unit's field's value in its calculation, so calc_seconds() adds the 
Convert::TimeUnit's object's seconds field to the total.

=back

=back

=head2 FUNCTION-ORIENTED INTERFACE

=over 4 

Functions

=over 2

All Convert::TimeUnits functions accessible via the function-oriented interface
are of the form foo_to_bar , where foo and bar are plural unit names. For
example, to convert from hours to seconds, call hours_to_seconds(). Each
function takes a numeric argument and returns a numeric argument.

=back

Exported functions

=over 2

None by default.

=back

=back

=head1 SEE ALSO

units(1), perl(1)

=head1 CONFORMANCE

All of the values in Convert::TimeUnits have been derived from the units(1)
program, version 1.0, and the accompanying units.lib file, version $FreeBSD:
src/usr.bin/units/units.lib,v 1.15 2003/11/05 22:29:48 mph Exp $ , as shipped
with FreeBSD 5.2.1. Discrepancies with GNU units presumed to be nonexistent
because both FreeBSD's units.lib and GNU unit's units.dat both define the number
of seconds in a year to be 31556926. All relations are interdependent, and this
equality mathematically requires all relations (anamolies excepted) to be equal.
The author wholeheartedly invites those in the appropriate fields of endeavor 
to test this software and report any inaccuracies and / or inconsistencies with
corrections if possible and rationales if applicable.

Any changes to the conformance of Convert::TimeUnits shall be ostensibly
annotated here and in the source distribution's accompanying README.

=head1 AUTHOR

Christopher Nehren, E<lt>apeiron@comcast.netE<gt> Meaghan Hayes contributed the
idea to include a weeks field and functions.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Christopher Nehren

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.00_5 or,
at your option, any later version of Perl 5 you may have available.


=cut

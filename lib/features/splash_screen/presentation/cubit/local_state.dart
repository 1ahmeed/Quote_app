

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class LocalState extends Equatable {
final Locale locale;

 const LocalState(this.locale);
  @override
  List<Object?> get props => [locale];
}

class LocalInitial extends LocalState {
 const LocalInitial(super.locale);
}

class ChangeLocalState extends LocalState {
 const ChangeLocalState(Locale selectedLocale):super(selectedLocale);
}



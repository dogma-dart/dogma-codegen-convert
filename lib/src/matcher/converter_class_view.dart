// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';

import '../../libraries.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Matcher for the create method in the model decoder class.
bool createMethodMatch(Metadata metadata) =>
    (metadata as ClassMetadata).methods.any(nameMatch(createMethodName));

/// Matcher for the convert method for a converter.
bool convertMethodMatch(Metadata metadata) =>
    (metadata as ClassMetadata).methods.any(nameMatch(convertMethodName));

/// Matcher for a model decoder.
MetadataMatchFunction decoderViewMatch = andList([
  // Needs to be a class
  classMetadataMatch,
  // Class needs to be concrete
  concreteMatch,
  // Class needs to implement ModelDecoder
  interfaceMatch(genericModelDecoderType),
  // Class needs to contain a create method
  createMethodMatch,
  // Class needs to contain a convert method
  convertMethodMatch
]);

/// Matcher for a model encoder.
MetadataMatchFunction encoderViewMatch = andList([
  // Class needs to be concrete
  concreteMatch,
  // Class needs to implement ModelDecoder
  interfaceMatch(genericModelEncoderType),
  // Class needs to contain a convert method
  convertMethodMatch
]);

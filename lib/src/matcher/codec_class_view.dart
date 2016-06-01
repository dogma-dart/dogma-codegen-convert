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

/// Matches classes that are ModelCodecs
MetadataMatchFunction codecViewMatch = andList([
  // Needs to be a class
  classMetadataMatch,
  // Class needs to be concrete
  concreteMatch,
  // Supertype should be descended from ModelCodec
  supertypeMatch(genericModelCodecType),
  // Should have a single default constructor with two named parameters
  _hasCodecDefaultConstructor
]);

/// Check whether the [metadata] has a properly formed constructor.
bool _hasCodecDefaultConstructor(Metadata metadata) {
  var clazz = metadata as ClassMetadata;

  var defaultConstructor = clazz.constructors.firstWhere(
      defaultConstructorMatch,
      orElse: () => null
  );

  if (defaultConstructor != null) {
    var parameters = defaultConstructor.parameters;

    // See if the expected parameters are present
    //
    // Just check the type rather than the name as it could be user defined
    if (parameters.length == 2) {
      var decoderParameter = parameters.firstWhere(
          typeMatch(genericModelDecoderType),
          orElse: () => null
      );

      var encoderParameter = parameters.firstWhere(
          typeMatch(genericModelEncoderType),
          orElse: () => null
      );

      return decoderParameter != null && encoderParameter != null;
    }
  }

  return false;
}

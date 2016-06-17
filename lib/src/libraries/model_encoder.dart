// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/metadata.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// The name of the model encoder class.
const String modelEncoderClassName = 'ModelEncoder';

/// A generic model encoder type.
///
/// The type arguments are not specified which will allow equality matching.
final TypeMetadata genericModelEncoderType =
    new TypeMetadata(modelEncoderClassName);

/// Creates type metadata for a ModelEncoder using the [model]'s type.
TypeMetadata modelEncoderType(TypeMetadata model) =>
    new TypeMetadata(modelEncoderClassName, arguments: [model]);

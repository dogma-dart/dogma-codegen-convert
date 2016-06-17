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

/// The name of the model decoder class.
const String modelDecoderClassName = 'ModelDecoder';

/// The name of the create method.
///
/// This is defined on ModelDecoder.
const String createMethodName = 'create';

/// A generic model decoder type.
///
/// The type arguments are not specified which will allow equality matching.
final TypeMetadata genericModelDecoderType = new TypeMetadata(modelDecoderClassName);

/// Creates type metadata for a ModelDecoder using the [model]'s type.
TypeMetadata modelDecoderType(TypeMetadata model) =>
    new TypeMetadata(modelDecoderClassName, arguments: [model]);

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

/// The class name for the converter class within `dart:convert`.
const String converterClassName = 'Converter';

/// The method name for the conversion method.
///
/// This is defined in Converter within `dart:convert`.
const String convertMethodName = 'convert';

/// Creates type metadata for a Converter being used as a ModelDecoder using
/// the [model]'s type.
///
/// A decoder extends the Converter type and then implements the ModelDecoder
/// type. This is used as the base type for generated decoders.
TypeMetadata converterDecoderType(TypeMetadata model) =>
    new TypeMetadata(
        converterClassName,
        arguments: [new TypeMetadata.map(), model]
    );

/// Creates type metadata for a Converter being used as a ModelEncoder using
/// the [model]'s type.
///
/// An encoder extends the Converter type and then implements the ModelEncoder
/// type. This is used as the base type for generated encoders.
TypeMetadata converterEncoderType(TypeMetadata model) =>
    new TypeMetadata(
        converterClassName,
        arguments: [model, new TypeMetadata.map()]
    );

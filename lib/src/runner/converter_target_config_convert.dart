// Copyright (c) 2015-2016 the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:convert';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/runner.dart';
import 'package:dogma_convert/convert.dart';

import '../../build.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Decoder for [ConverterTargetConfig]s.
class ConverterTargetConfigDecoder extends Converter<Map, ConverterTargetConfig>
                                implements ModelDecoder<ConverterTargetConfig> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The base decoder for [TargetConfig]s.
  final ModelDecoder<TargetConfig> targetConfigDecoder;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ConverterTargetConfigDecoder].
  const ConverterTargetConfigDecoder({this.targetConfigDecoder: const TargetConfigDecoder()});

  //---------------------------------------------------------------------
  // ModelDecoder
  //---------------------------------------------------------------------

  @override
  ConverterTargetConfig create() => new ConverterTargetConfig();

  @override
  ConverterTargetConfig convert(Map input, [ConverterTargetConfig model]) {
    model ??= create();

    targetConfigDecoder.convert(input, model);

    return model;
  }
}

// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/codegen.dart';
import 'package:dogma_source_analyzer/metadata.dart';

import '../../view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates source code for the codec [view] into the [buffer].
void generateCodec(CodecClassView view, StringBuffer buffer) {
  generateClassDefinition(
      view.metadata,
      buffer,
      _generateCodecDefinition(view)
  );
}

ClassGenerator _generateCodecDefinition(CodecClassView view) =>
    (metadata, buffer) {
      generateConstructorDefinition(
          metadata.constructors[0],
          buffer,
          initializerListGenerator: _generateCodecInitializeList
      );
    };

void _generateCodecInitializeList(ConstructorMetadata constructor,
                                  StringBuffer buffer) {
  buffer.write('super(');
  var arguments = new ArgumentBuffer();

  // Just pass through the parameters
  for (var parameter in constructor.parameters) {
    var name = parameter.name;
    arguments.write('$name: $name');
  }

  buffer.write(arguments.toString());
  buffer.write(')');
}

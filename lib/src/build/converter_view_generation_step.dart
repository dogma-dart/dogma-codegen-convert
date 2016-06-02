// Copyright (c) 2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------


import 'package:dogma_codegen/build.dart';
import 'package:dogma_codegen/view.dart';
import 'package:dogma_codegen_model/view.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/path.dart' as p;

import '../../view.dart';
import '../../libraries.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

class ConverterViewGenerationStep implements ViewGenerationStep {
  //---------------------------------------------------------------------
  // ViewGenerationStep
  //---------------------------------------------------------------------

  @override
  MetadataView<LibraryMetadata> viewGeneration(MetadataView<LibraryMetadata> source) {
    var modelView = source as ModelLibraryView;

    // Generate the convert elements
    var classes = <ClassMetadata>[];

    for (var model in modelView.models) {
      classes
          ..add(_generateModelDecoder(model))
          ..add(_generateModelEncoder(model))
          ..add(_generateModelCodec(model));
    }

    // Create the libraries
    var library = new LibraryMetadata(
        p.join('test/lib/src/convert/test_convert.dart'),
        classes: classes,
        imports: [
          dartConvertReference(),
          dogmaConvertReference(),
          new UriReferencedMetadata.withLibrary(source.metadata)
        ]
    );

    return new ConverterLibraryView(library);
  }

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Gets the default name for an decoder with the given [modelType].
  static String defaultDecoderName(String modelType) => '${modelType}Decoder';

  /// Gets the default name for an encoder with the given [modelType].
  static String defaultEncoderName(String modelType) => '${modelType}Encoder';

  /// Gets the default name for a codec with the given [modelType].
  static String defaultCodecName(String modelType) => '${modelType}Codec';

  /// Generates a model decoder from the given [model].
  static ClassMetadata _generateModelDecoder(ModelClassView model) {
    var metadata = model.metadata;
    var metadataType = metadata.type;
    var name = defaultDecoderName(metadata.name);

    // Get the dependencies

    var fields = <FieldMetadata>[];
    var parameters = <ParameterMetadata>[];

    // Create the default constructor
    var defaultConstructor = new ConstructorMetadata(
        new TypeMetadata(name),
        isConst: true,
        parameters: parameters
    );

    // Create the methods
    var methods = <MethodMetadata>[
      new MethodMetadata(
          createMethodName,
          metadataType,
          annotations: [override]
      ),
      new MethodMetadata(
          convertMethodName,
          metadataType,
          parameters: <ParameterMetadata>[
            new ParameterMetadata('input', new TypeMetadata.map()),
            new ParameterMetadata(
                'model',
                metadataType,
                parameterKind: ParameterKind.positional
            )
          ],
          annotations: [override]
      )
    ];

    return new ClassMetadata(
        name,
        supertype: converterDecoderType(metadataType),
        interfaces: [modelDecoderType(metadataType)],
        constructors: [defaultConstructor],
        fields: fields,
        methods: methods
    );
  }

  /// Generates a model encoder from the given [model].
  static ClassMetadata _generateModelEncoder(ModelClassView model) {
    var metadata = model.metadata;
    var metadataType = metadata.type;
    var name = defaultEncoderName(metadata.name);

    // Get the dependencies

    var fields = <FieldMetadata>[];
    var parameters = <ParameterMetadata>[];

    // Create the default constructor
    var defaultConstructor = new ConstructorMetadata(
        new TypeMetadata(name),
        isConst: true,
        parameters: parameters
    );

    // Create the methods
    var methods = <MethodMetadata>[
      new MethodMetadata(
          convertMethodName,
          new TypeMetadata.map(),
          parameters: <ParameterMetadata>[
            new ParameterMetadata('input', metadataType),
          ],
          annotations: [override]
      )
    ];

    return new ClassMetadata(
        name,
        supertype: converterEncoderType(metadataType),
        interfaces: [modelEncoderType(metadataType)],
        constructors: [defaultConstructor],
        fields: fields,
        methods: methods
    );
  }

  /// Generates a model codec from the given [model].
  static ClassMetadata _generateModelCodec(ModelClassView model) {
    var metadata = model.metadata;
    var metadataType = metadata.type;
    var name = defaultCodecName(metadata.name);

    // Create the default constructor
    var defaultConstructor = new ConstructorMetadata(
        new TypeMetadata(name),
        isConst: true,
        parameters: <ParameterMetadata>[
          new ParameterMetadata(
              'decoder',
              modelDecoderType(metadataType),
              parameterKind: ParameterKind.named
          ),
          new ParameterMetadata(
              'encoder',
              modelEncoderType(metadataType),
              parameterKind: ParameterKind.named
          )
        ]
    );

    return new ClassMetadata(
        name,
        supertype: modelCodecType(metadataType),
        constructors: <ConstructorMetadata>[defaultConstructor]
    );
  }
}

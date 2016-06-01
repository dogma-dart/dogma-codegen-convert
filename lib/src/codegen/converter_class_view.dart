// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_codegen/codegen.dart';
import 'package:dogma_codegen_model/view.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/query.dart';

import '../../libraries.dart';
import '../../view.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Generates source code for the converter [view] into the [buffer].
void generateConverter(ConverterClassView view, StringBuffer buffer) {
  // Get the model
  var model = _getModelView(view);

  generateClassDefinition(
      view.metadata,
      buffer,
      _generateConverterDefinition(view, model)
  );
}

/// Find the model that the [view] needs to serialize.
ModelClassView _getModelView(ConverterClassView view) {
  var library = view.metadata.enclosingMetadata as LibraryMetadata;

  var model = libraryMetadataQuery/*<ClassMetadata>*/(
      library,
      typeMatch(view.modelType),
      includeImports: true,
      includeClasses: true
  );

  assert(model != null);

  return new ModelClassView(model);
}

/// Creates a function that generates the class definition for the converter
/// [view] which serializes the [model].
ClassGenerator _generateConverterDefinition(ConverterClassView view,
                                            ModelClassView model) =>
    (metadata, buffer) {
      // Create the fields
      generateFields(metadata.fields, buffer);

      // Create the default constructor
      //
      // Even if no parameters are present it still needs to be written out
      // as it is const.
      assert(metadata.constructors.length == 1);

      generateConstructorDefinition(
          metadata.constructors[0],
          buffer,
          useThis: true
      );

      // Create the create method
      if (view.isDecoder) {
        var createMethod = classMetadataQuery/*<MethodMetadata>*/(
            metadata,
            nameMatch(createMethodName),
            includeMethods: true
        );

        assert(createMethod != null);

        generateFunctionDefinition(
            createMethod,
            buffer,
            _generateCreateMethodDefinition,
            annotationGenerators: [generateOverrideAnnotation],
            useArrow: true
        );
      }

      // Create the convert method
      var convertMethod = classMetadataQuery/*<MethodMetadata>*/(
          metadata,
          nameMatch(convertMethodName),
          includeMethods: true
      );

      assert(convertMethod != null);

      generateFunctionDefinition(
          convertMethod,
          buffer,
          _generateConvertMethodDefinition(view, model),
          annotationGenerators: [generateOverrideAnnotation]
      );
    };

void _generateCreateMethodDefinition(FunctionMetadata metadata,
                                     StringBuffer buffer) {
  buffer.write(generateConstructorCall(metadata.returnType));
}

FunctionGenerator _generateConvertMethodDefinition(ConverterClassView view,
                                                   ModelClassView model) =>
    (metadata, buffer) {

    };

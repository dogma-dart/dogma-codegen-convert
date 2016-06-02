// Copyright (c) 2015-2016, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_source_analyzer/metadata.dart';
import 'package:test/test.dart';

import 'package:dogma_codegen_convert/matcher.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

final TypeMetadata _mapType = new TypeMetadata.map();
final TypeMetadata _fooType = new TypeMetadata('Foo');

final String _fooDecoderClassName = 'FooDecoder';
final ClassMetadata _fooDecoderClass = new ClassMetadata(
    _fooDecoderClassName,
    supertype: new TypeMetadata('Converter', arguments: [
      _mapType,
      _fooType
    ]),
    interfaces: [
      new TypeMetadata('ModelDecoder', arguments: [_fooType])
    ],
    constructors: [
      new ConstructorMetadata(new TypeMetadata(_fooDecoderClassName))
    ],
    methods: [
      new MethodMetadata('create', _fooType, annotations: [override]),
      new MethodMetadata('convert',
          _fooType,
          parameters: [
            new ParameterMetadata('input', _mapType),
            new ParameterMetadata('model', _fooType, parameterKind: ParameterKind.positional)
          ]
      )
    ]
);

final String _fooEncoderClassName = 'FooEncoder';
final ClassMetadata _fooEncoderClass = new ClassMetadata(
    _fooEncoderClassName,
    supertype: new TypeMetadata('Converter', arguments: [
      _fooType,
      _mapType
    ]),
    interfaces: [
      new TypeMetadata('ModelEncoder', arguments: [_fooType])
    ],
    constructors: [
      new ConstructorMetadata(new TypeMetadata(_fooEncoderClassName))
    ],
    methods: [
      new MethodMetadata('convert',
          _fooType,
          parameters: [new ParameterMetadata('input', _fooType)]
      )
    ]
);

final ClassMetadata _notConverter = new ClassMetadata('NotConverter');

void main() {
  test('createMethodMatch', () {
    expect(createMethodMatch(_fooDecoderClass), isTrue);
    expect(createMethodMatch(_fooEncoderClass), isFalse);
    expect(createMethodMatch(_notConverter), isFalse);
  });
  test('convertMethodMatch', () {
    expect(convertMethodMatch(_fooDecoderClass), isTrue);
    expect(convertMethodMatch(_fooEncoderClass), isTrue);
    expect(convertMethodMatch(_notConverter), isFalse);
  });
  test('decoderViewMatch', () {
    expect(decoderViewMatch(_fooDecoderClass), isTrue);
    expect(decoderViewMatch(_fooEncoderClass), isFalse);
    expect(decoderViewMatch(_notConverter), isFalse);
  });
  test('encoderViewMatch', () {
    expect(encoderViewMatch(_fooDecoderClass), isFalse);
    expect(encoderViewMatch(_fooEncoderClass), isTrue);
    expect(encoderViewMatch(_notConverter), isFalse);
  });
}

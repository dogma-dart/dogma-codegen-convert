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

/// Metadata for the dogma_convert.convert libraries.
final LibraryMetadata dogmaConvertLibrary =
    new LibraryMetadata(Uri.parse('package:dogma_convert/convert.dart'));

/// Import for the dogma_convert.convert libraries.
UriReferencedMetadata dogmaConvertReference() =>
    new UriReferencedMetadata.withLibrary(dogmaConvertLibrary);

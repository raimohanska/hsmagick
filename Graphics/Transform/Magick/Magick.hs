module Graphics.Transform.Magick.Magick(module Foreign.C.Types,
              module Foreign,
              module Foreign.C.String,
              initialize_magick,
              get_exception_info,
              destroy_exception_info,
              clone_image_info,
              read_image,
              write_image,
              catch_exception,
              ------- transformations
              flip_image,
              flop_image,
              rotate_image,
              affine_transform,
              shear_image,
              chop_image,
              crop_image,
              flatten_images,
              mosaic_images,
              roll_image,
              shave_image,
              ------- resizing
              scale_image,
              magnify_image,
              minify_image,
              sample_image,
              thumbnail_image,
              resize_image,
              -- enhancements
              contrast_image,
              equalize_image,
              gamma_image,
              level_image,
              level_image_channel,
              modulate_image,
              negate_image,
              normalize_image,
              -- constitution
              constitute_image,
              dispatch_image,
              -- blob
              blob_to_image,
              image_to_blob,
              --export_image_pixel_area,
              export_pixel_area_options_init,
              import_image_pixel_area,
              import_pixel_area_options_init,
              ping_image,
              read_inline_image,
              -- composition
              composite_image,
              -- image methods
              access_definition, 
              add_definitions, 
              allocate_image, 
              allocate_image_colormap, 
              append_images, 
              average_images, 
              clip_path_image, 
              cycle_colormap_image, 
              describe_image, 
              destroy_image, 
              finalize_image,
              destroy_image_info, 
              get_image_clip_mask, 
              get_image_depth, 
              get_image_characteristics, 
              get_image_geometry, 
              get_image_info, 
              get_image_statistics, 
              get_image_type, 
              image_equals, 
              is_taint_image, 
              plasma_image, 
              reference_image, 
              remove_definitions, 
              replace_image_colormap, 
              set_image, 
              set_image_clip_mask, 
              set_image_depth, 
              set_image_opacity, 
              set_image_type, 
              texture_image,
              -- stuff what displays stuff
              animate_images,
              --- util (internal use only!)
              p_free,
              clone_image,
              fopen,
              fclose) where

import Graphics.Transform.Magick.Types

import Foreign
import Foreign.C.Types
import Foreign.C.String

-- The internal interface to the GraphicsMagick library. This
-- module should mostly (if not entirely) contain import declarations
-- for foreign calls.

-- also the place to dump in modules we'd like to re-export :-)

--------------- Basics
foreign import ccall "static magick/api.h InitializeMagick"
    initialize_magick :: Ptr a -> IO ()
    
foreign import ccall "static magick/api.h GetExceptionInfo"
    get_exception_info :: Ptr ExceptionInfo -> IO ()

foreign import ccall "static magick/api.h DestroyExceptionInfo"
    destroy_exception_info :: Ptr ExceptionInfo -> IO ()

foreign import ccall "static magick/api.h CloneImageInfo"
    clone_image_info :: Ptr HImageInfo -> IO (Ptr HImageInfo)

foreign import ccall "static magick/api.h ReadImage"
    read_image :: Ptr HImageInfo -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h WriteImage"
    write_image :: Ptr HImageInfo -> Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h CatchException"
    catch_exception :: Ptr ExceptionInfo -> IO ()
----------------- Constituting an image
foreign import ccall "static magick/api.h ConstituteImage"
    constitute_image :: CULong -> CULong -> CString -> CUInt 
      -> Ptr a -> Ptr ExceptionInfo -> IO (Ptr HImage_)
-- TODO: DestroyConstitute; do we need it?
foreign import ccall "static magick/api.h DispatchImage"
    dispatch_image :: Ptr HImage_ -> CULong -> CULong ->
      CULong -> CULong -> CString -> CUInt 
      -> Ptr a -> Ptr ExceptionInfo -> IO CUInt
{-
TODO: this doesn't seem to exist anymore...
foreign import ccall "static magick/api.h ExportImagePixelArea"
    export_image_pixel_area :: Ptr HImage_ -> CUInt -> CUInt ->
      Ptr a -> Ptr ExportPixelAreaOptions -> 
      Ptr ExportPixelAreaInfo -> IO CUInt
-}
foreign import ccall "static magick/api.h ExportPixelAreaOptionsInit"
    export_pixel_area_options_init :: 
       Ptr ExportPixelAreaOptions -> IO ()
foreign import ccall "static magick/api.h ImportImagePixelArea"
    import_image_pixel_area :: Ptr HImage_ -> CUInt -> CUInt ->
      CString -> Ptr ImportPixelAreaOptions -> 
      Ptr ImportPixelAreaInfo -> IO CUInt
foreign import ccall "static magick/api.h ImportPixelAreaOptionsInit"
    import_pixel_area_options_init :: 
       Ptr ImportPixelAreaOptions -> IO ()
foreign import ccall "static magick/api.h PingImage"
    ping_image :: Ptr HImageInfo -> Ptr ExceptionInfo -> IO (Ptr HImage_)
foreign import ccall "static magick/api.h ReadInlineImage"
    read_inline_image :: Ptr HImageInfo -> CString -> Ptr ExceptionInfo -> IO (Ptr HImage_)

----------------- Blob
foreign import ccall "static magick/api.h BlobToImage"
    blob_to_image :: Ptr HImageInfo -> Ptr CUChar -> CSize -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ImageToBlob"
    image_to_blob :: Ptr HImageInfo -> Ptr HImage_ -> Ptr CSize -> Ptr ExceptionInfo -> IO (Ptr CUChar)

----------------- Transformations

foreign import ccall "static magick/api.h FlipImage"
    flip_image :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h FlopImage"
    flop_image :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h RotateImage"
    rotate_image :: Ptr HImage_ -> CDouble -> Ptr ExceptionInfo 
                     -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h AffineTransformImage"
    affine_transform :: Ptr HImage_ -> Ptr AffineMatrix -> Ptr ExceptionInfo 
                          -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ShearImage"
    shear_image :: Ptr HImage_ -> CDouble -> CDouble -> Ptr ExceptionInfo 
                     -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ChopImage"
    chop_image :: Ptr HImage_ -> Ptr Rectangle -> Ptr ExceptionInfo 
                   -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h CropImage"
    crop_image :: Ptr HImage_ -> Ptr Rectangle -> Ptr ExceptionInfo 
                   -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h FlattenImages"
    flatten_images :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h MosaicImages"
    mosaic_images :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h RollImage"
    roll_image :: Ptr HImage_ -> CLong -> CLong -> Ptr ExceptionInfo 
                     -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ShaveImage"
    shave_image :: Ptr HImage_ -> Ptr Rectangle -> Ptr ExceptionInfo 
                     -> IO (Ptr HImage_)

----------------- Resizing
foreign import ccall "static magick/api.h ScaleImage"
    scale_image :: Ptr HImage_ -> CULong -> CULong -> Ptr ExceptionInfo
                   -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h MagnifyImage"
    magnify_image :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h MinifyImage"
    minify_image :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h SampleImage"
    sample_image :: Ptr HImage_ -> CULong -> CULong -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ThumbnailImage"
    thumbnail_image :: Ptr HImage_ -> CULong -> CULong -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ResizeImage"
    resize_image :: Ptr HImage_ -> CULong -> CULong -> CUInt -> CDouble -> 
                      Ptr ExceptionInfo -> IO (Ptr HImage_)
---------- Enhancements

-- Note that these side-effect the image! Higher-level API
-- has to hide this from the user via copying.
foreign import ccall "static magick/api.h ContrastImage"
    contrast_image :: Ptr HImage_ -> CUInt -> IO CUInt

foreign import ccall "static magick/api.h EqualizeImage"
    equalize_image :: Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h GammaImage"
    gamma_image :: Ptr HImage_ -> CString -> IO CUInt

foreign import ccall "static magick/api.h LevelImage"
    level_image :: Ptr HImage_ -> CString -> IO CUInt

foreign import ccall "static magick/api.h LevelImageChannel"
    level_image_channel :: Ptr HImage_ -> CUInt -> 
       CDouble -> CDouble -> CDouble -> IO CUInt

foreign import ccall "static magick/api.h ModulateImage"
    modulate_image :: Ptr HImage_ -> CString -> IO CUInt

foreign import ccall "static magick/api.h NegateImage"
    negate_image :: Ptr HImage_ -> CUInt -> IO CUInt

foreign import ccall "static magick/api.h NormalizeImage"
    normalize_image :: Ptr HImage_ -> IO CUInt

---------- Composition

foreign import ccall "static magick/api.h CompositeImage"
    composite_image :: Ptr HImage_ -> CUInt -> Ptr HImage_ -> CLong -> CLong 
       -> IO CUInt

---------- Image methods
foreign import ccall "static magick/api.h AccessDefinition"
    access_definition :: Ptr HImageInfo -> CString -> CString -> IO CString

foreign import ccall "static magick/api.h AddDefinitions"
    add_definitions :: Ptr HImageInfo -> CString -> IO ()

foreign import ccall "static magick/api.h AllocateImage"
    allocate_image :: Ptr HImageInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h AllocateImageColormap"
    allocate_image_colormap :: Ptr HImage_ -> CULong -> IO CUInt

foreign import ccall "static magick/api.h AnimateImages"
    animate_images :: Ptr HImageInfo -> Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h AppendImages"
    append_images :: Ptr HImage_ -> CUInt -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h AverageImages"
    average_images :: Ptr HImage_ -> Ptr ExceptionInfo -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h ClipPathImage"
    clip_path_image :: Ptr HImage_ -> CString -> CUInt -> IO CUInt

foreign import ccall "static magick/api.h CycleColormapImage"
    cycle_colormap_image :: Ptr HImage_ -> CInt -> IO CUInt

foreign import ccall "static magick/api.h DescribeImage"
    describe_image :: Ptr HImage_ -> Ptr CFile -> CUInt -> IO CUInt

foreign import ccall "static magick/api.h DestroyImage"
    destroy_image :: Ptr HImage_ -> IO ()

foreign import ccall "static magick/api.h &DestroyImage"
    finalize_image :: FunPtr(Ptr HImage_ -> IO ())

foreign import ccall "static magick/api.h DestroyImageInfo"
    destroy_image_info :: Ptr HImageInfo -> IO ()

foreign import ccall "static magick/api.h GetImageClipMask"
    get_image_clip_mask :: Ptr HImage_ -> Ptr ExceptionInfo -> Ptr HImage_

foreign import ccall "static magick/api.h GetImageDepth"
    get_image_depth :: Ptr HImage_ -> Ptr ExceptionInfo -> IO CULong

foreign import ccall "static magick/api.h GetImageCharacteristics"
    get_image_characteristics :: Ptr HImage_ -> Ptr ImageCharacteristics -> CUInt -> Ptr ExceptionInfo -> IO CUInt

foreign import ccall "static magick/api.h GetImageGeometry"
    get_image_geometry :: Ptr HImage_ -> CString -> CUInt -> Ptr Rectangle -> IO CInt

foreign import ccall "static magick/api.h GetImageInfo"
    get_image_info :: Ptr HImageInfo -> IO ()

foreign import ccall "static magick/api.h GetImageStatistics"
    get_image_statistics :: Ptr HImage_ -> Ptr ImageStatistics -> Ptr ExceptionInfo -> IO CUInt

foreign import ccall "static magick/api.h GetImageType"
    get_image_type :: Ptr HImage_ -> Ptr ExceptionInfo -> IO ImageType

foreign import ccall "static magick/api.h IsImagesEqual"
    image_equals :: Ptr HImage_ -> Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h IsTaintImage"
    is_taint_image :: Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h PlasmaImage"
    plasma_image :: Ptr HImage_ -> Ptr SegmentInfo -> CULong -> CULong -> IO CUInt

foreign import ccall "static magick/api.h ReferenceImage"
    reference_image :: Ptr HImage_ -> IO (Ptr HImage_)

foreign import ccall "static magick/api.h RemoveDefinitions"
    remove_definitions :: Ptr HImageInfo -> CString -> Ptr ExceptionInfo -> IO ()
                       
foreign import ccall "static magick/api.h ReplaceImageColormap"
    replace_image_colormap :: Ptr HImage_ -> Ptr (PixelPacket Word16) -> CUInt -> IO CUInt

foreign import ccall "static magick/api.h SetImage"
    set_image :: Ptr HImage_ -> CUInt -> IO ()

foreign import ccall "static magick/api.h SetImageClipMask"
    set_image_clip_mask :: Ptr HImage_ -> Ptr HImage_ -> IO CUInt

foreign import ccall "static magick/api.h SetImageDepth"
    set_image_depth :: Ptr HImage_ -> CULong -> IO CUInt
                           
foreign import ccall "static magick/api.h SetImageOpacity"
    set_image_opacity :: Ptr HImage_ -> CUInt -> IO ()

foreign import ccall "static magick/api.h SetImageType"
    set_image_type :: Ptr HImage_ -> ImageType -> IO ()

foreign import ccall "static magick/api.h TextureImage"
    texture_image :: Ptr HImage_ -> Ptr HImage_ -> IO CUInt

---------- util (internal library use only)
foreign import ccall "stdlib.h &free"
   p_free :: FunPtr (Ptr a -> IO ())

foreign import ccall "static magick/api.h CloneImage"
   clone_image :: Ptr HImage_ -> CULong -> CULong -> CUInt -> Ptr ExceptionInfo
                   -> IO (Ptr HImage_)

foreign import ccall unsafe "stdlib.h fopen"
   fopen :: CString -> CString -> IO (Ptr CFile) 

foreign import ccall unsafe "stdlib.h fclose"
   fclose :: Ptr CFile -> IO ()

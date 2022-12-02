# tensorflow == 2.8.0
# onnx == 1.10.2
# onnx-tf == 1.10.0
# tensorflow-probability == 0.16.0      # https://github.com/tensorflow/probability/releases

import onnx
from onnx_tf.backend import prepare
import tensorflow as tf
import argparse

if __name__=='__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--weights', type=str, default="runs/train/tour_tiny2/weights/best.onnx", help='weights path')
    opt = parser.parse_args()
    
    model_path = opt.weights
    onnx_model = onnx.load(model_path)
    tf_rep = prepare(onnx_model)

    model_path = model_path.replace('.onnx','_pb')
    print(model_path)
    tf_rep.export_graph(model_path)
    print("Converting onnx -> tensorflow completes successfully.\n\n")

    # make a converter object from the saved tensorflow file
    # converter = tf.lite.TFLiteConverter.from_frozen_graph(model_path, #TensorFlow freezegraph .pb model file
    #                                                       input_arrays=['inputs'], # name of input arrays as defined in torch.onnx.export function before.
    #                                                       output_arrays=['outputs']  # name of output arrays defined in torch.onnx.export function before.
    #                                                       )
    converter = tf.lite.TFLiteConverter.from_saved_model(model_path)
    # converter =  tf.compat.v1.lite.TFLiteConverter.from_saved_model(model_path, signature_keys=['serving_default'])

    # tell converter which type of optimization techniques to use
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    converter.target_spec.supported_types = [tf.float16]
    # to view the best option for optimization read documentation of tflite about optimization
    # go to this link https://www.tensorflow.org/lite/guide/get_started#4_optimize_your_model_optional

    # convert the model 
    tf_lite_model = converter.convert()
    print('Converting tf -> tf_lite completes successfully.\n\n')
    # save the converted model 
    model_path = model_path.replace('_pb','-fp16.tflite')
    open(model_path, 'wb').write(tf_lite_model)
    print(f'{model_path} save tf-lite')
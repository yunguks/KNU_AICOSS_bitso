# KNU_AICOSS_bitso

랜드마크 인증을 위한 yolo 학습
</br>

## 1. Data
- 라벨링 툴
    - [CVAT](https://github.com/opencv/cvat)
    - [Yolo_Label](https://github.com/developer0hye/Yolo_Label)
</br>

## 2. Model
- yolov5s    
    models/custom_yolov5s.yaml 파일 num_class 변경
```
# Parameters
nc: {num_classes}  # number of classes
depth_multiple: 0.33  # model depth multiple
width_multiple: 0.50  # layer channel multiple
anchors:
  - [10,13, 16,30, 33,23]  # P3/8
  - [30,61, 62,45, 59,119]  # P4/16
  - [116,90, 156,198, 373,326]  # P5/32
'''
```
</br>

## 3. Train
- hpy    
    data/hpy/custom.yaml hyper parameter 수정 
```
lr0: 0.002
lrf: 0.002
momentum: 0.937
weight_decay: 0.0005
warmup_epochs: 3.0
warmup_momentum: 0.8
warmup_bias_lr: 0.07
box: 0.05
cls: 0.7
cls_pw: 0.8
obj: 1.3
obj_pw: 1.2
iou_t: 0.2
anchor_t: 4.0
fl_gamma: 1.0
hsv_h: 0.015
hsv_s: 0.5
hsv_v: 0.4
degrees: 0.0
translate: 0.1
scale: 0.5
shear: 0.0
perspective: 0.0
flipud: 0.0
fliplr: 0.5
mosaic: 1.0
mixup: 0.1
copy_paste: 0.0
```
</br>

- Train

```
python3 train.py --weights [using yolov5s] --cfg models/y5s_model.yaml --data [custom_data.yaml] --hpy [custom_hyp.yaml] --img 416
```
</br>

## 4. Convert
Tensorflow Lite 모델로 변환
```
python3 export.py --weights [weights] --img 416 --half --iou-thres 0.6 --conf-thres 0.1
```
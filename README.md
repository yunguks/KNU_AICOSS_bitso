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
</br>

## 3. Train
- hpy    
    data/hpy/custom.yaml hyper parameter 수정 

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
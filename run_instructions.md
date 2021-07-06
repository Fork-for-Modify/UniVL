## 使用自己的视频完成caption的过程（基于MSRVTT预训练模型）

1. 预训练caption模型：在提供的 pretrian model, MSRVTT（特征）数据集和代码上完成 caption 任务的预训练, 得到 caption 任务的预训练模型
2. 视频特征提取：根据 https://github.com/ArrowLuo/VideoFeatureExtractor 提取自己的视频的 S3D 特征

   1. 配置环境（westlake server py_univl conda环境中已经配置好）
   2. 产生csv文件
      ```
      python preprocess_generate_csv.py --csv=input.csv --video_root_path [VIDEO_PATH] --feature_root_path [FEATURE_PATH] --csv_save_path [CSV_PATH]

       python preprocess_generate_csv.py --csv=input.csv --video_root_path video/sci_city_traffic/ --feature_root_path feature/sci_city_traffic/ --csv_save_path csv/

      ```
   3. 提取视频特征得到pickle文件
   
      ```
      python extract.py --csv=[CSV_PATH] --type=s3dg --batch_size=64 --num_decoding_thread=4

      python extract.py --csv=./csv/input.csv --type=s3dg --batch_size=64 --num_decoding_thread=4

      ```
   4. pickle文件转换为npy文件
      ```
      python convert_video_feature_to_pickle.py --feature_root_path [FEATURE_PATH] --pickle_root_path [PICKLE_PATH] --pickle_name [PICKLE_NAME]

      python convert_video_feature_to_pickle.py --feature_root_path feature/sci_city_traffic/ --pickle_root_path feature_pickle/ --pickle_name sci_city_traffic.pickle

      ```
3. 数据准备：

   (0) 将提取的视频特征放到指定数据文件夹
   cp /home/xiongfei/zhihong/project/SCI_caption/S3D_VideoFeatureExtractor/feature_pickle/sci_city_traffic.pickle /home/xiongfei/zhihong/project/SCI_caption/UniVL/data/sci_city_traffic/

   (1) 类比原代码新建 `VAL_CSV` 文件（如 `MSRVTT_JSFUSION_test.csv`），主要是将其中的 `video_id `字段改为自己的视频的名字。the VAL_CSV is just used to get the feature dim (1024 for S3D here).`sentence` 可以自己描述一段，用来对比生成的结果（算指标）

   (2) 类比原代码新建 `DATA_PATH`  文件（如 `MSRVTT_JSFUSION_test.csv`），内容类似于 `{"sentences":[{"caption": "an orange car is chasing a gray car", "video_id": "chasing", "sen_id": 1}, {"caption": "many cars are parking on the road", "video_id": "red_gray", "sen_id": 2}, {"caption": "three cars are running on the road", "video_id": "parking", "sen_id": 3}]}`, 即将 `VAL_CSV` 内容复制过来即可，`sen_id` 随便给个序号就行
4. `run_realTest.sh` 指定参数并运行 (主函数代码使用 `main_mytask_caption.py`）

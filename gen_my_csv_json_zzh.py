import pandas as pd
import json

## params
orig_names = ['bus', 'car', 'football',
              'run', 'tennis']
suffixs = ['',  '_sci20']
save_csv_path = './data/pipeline_test/pipeline_test.csv'
save_json_path = './data/pipeline_test/pipeline_test.json'

## csv
video_id = [] # orig_name + suffix
for suffix in suffixs:
    for orig_name in orig_names:
        video_id.append(orig_name+suffix)

video_id.sort()
vid_num = len(video_id)

key = ['ret'+str(x) for x in range(vid_num)] # doesn't matter (not repeat)
vid_key = key # doesn't matter
sentence = key # doesn't matter

data = {'key':key,'vid_key':vid_key,'video_id':video_id,'sentence':sentence}
df = pd.DataFrame(data)
print(df)
df.to_csv(save_csv_path,index=False)


## json
{"sentences":[{"caption": "an orange car is chasing a gray car", "video_id": "gapfastdvdnet_chasing", "sen_id": 1}, {"caption": "many cars are parking on the road", "video_id": "gapfastdvdnet_red_gray", "sen_id": 2}, {"caption": "three cars are running on the road", "video_id": "gapfastdvdnet_parking", "sen_id": 3}]}

sent_list = []
for k, video_id_k in enumerate(video_id):
    item_dict = {"caption":'xxx', "video_id":video_id_k, "sen_id":k+1}
    sent_list.append(item_dict)

json_info = {"sentences": sent_list}
print(json_info)
with open(save_json_path,'w') as file_obj:
    json.dump(json_info,file_obj)

import json
import os
import argparse

def read_config(path):
    config = json.loads(open(path).read())
    return config

def evaluate(config):
    f = open(config['output_path']+ 'result_times.csv', 'w')
    f.write("run,elapsed_time,kernel_mode,user_mode,memory_max,memory_average\n")
    f.close()    
    f = open('.tempScript.sh', 'w')
    f.write(config['cmd'] + '\n')
    f.close()
    for i in range(config['rounds']):
        os.system('/usr/bin/time -f "'+ str(i) + ',%e,%S,%U,%M,%K" --append -o ' + config['output_path'] + 'result_times.csv bash .tempScript.sh')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', "--config", required=True, help="Path of the configuration file")
    args = parser.parse_args()
    conf = read_config(args.config)
    evaluate(conf)
    print("Evaluation Finished")

if __name__=='__main__':
    main()
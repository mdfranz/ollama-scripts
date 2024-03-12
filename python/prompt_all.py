#!/usr/bin/env python3

import ollama,csv,datetime

# global so we can use it as a title for CSV
STAT_FIELDS = ['model','total_duration','load_duration','prompt_eval_duration','eval_count','eval_duration']

def get_stats_row(r):
  """Extracts interesting model execution stats and puts in a line for CSV"""
  row = []
  for s in STAT_FIELDS:
    row.append(r[s])

  print (row)
  return row

if __name__ == "__main__":
  print ("Getting models!") 

  statfile = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
  p = input("What is your question>")

  with open(statfile+".txt","w") as promptfile:
    promptfile.write("PROMPT:"+p)
    with open(statfile+".csv","w") as csvfile:
      writer = csv.writer(csvfile)
      writer.writerow(STAT_FIELDS)
      for m in  ollama.list()['models']:
        m_name = (m['name'])

        print("\n\n****** ",m_name,"******")
        r = ollama.generate(model=m_name,prompt=p)
        writer.writerow(get_stats_row(r))

        promptfile.write("\n\n****** " + m_name + "******\n")
        promptfile.write(r['response']) 

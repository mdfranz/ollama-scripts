#!/usr/bin/env python3

import ollama

# global so we can use it as a title for CSV
STAT_FIELDS = ['model','total_duration','load_duration','prompt_eval_duration','eval_count','eval_duration']

def get_stats_row(r)
  """Extracts interesting model execution stats and puts in a line for CSV"""
  row = []
  for s in STAT_FIELDS:
    row.append(r[s])

if __name__ == "__main__":
  print ("Getting models!") 
  p = input("What is your question>")

  for m in  ollama.list()['models']:
    m_name = (m['name'])

    print("\n\n****** ",m_name,"******")
    r = ollama.generate(model=m_name,prompt=p)
    print(r['total_duration']) 
    print(r['response'])

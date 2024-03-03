#!/usr/bin/env python3

import ollama

if __name__ == "__main__":
  print ("Getting models!") 

  p = input("What is your question>")

  for m in  ollama.list()['models']:
    m_name = (m['name'])

    print("\n\n****** ",m_name,"******")
    r = ollama.generate(model=m_name,prompt=p)
    print(r['total_duration']) 
    print(r['response'])

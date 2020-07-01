from pyresparser import ResumeParser
import json 
import sys

filepath = sys.argv[1]
data = ResumeParser(filepath).get_extracted_data()
print(json.dumps(data), end='')
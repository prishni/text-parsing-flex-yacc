import os
import sys
import subprocess

fac = os.listdir('./fac')
for f in fac:
	print(f)
	subprocess.call(['./ex1',f])
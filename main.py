import os
import sys
import subprocess

fac = os.listdir('./fac')
for f in fac:
	subprocess.call(['./ex1',f])
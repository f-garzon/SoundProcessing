import psutil
import time
import subprocess

process_name = "SoundTrapCardReader.exe"
idle_threshold = 1.0  # % CPU — below this = considered idle
idle_duration = 10    # seconds it must stay idle to confirm it's done

def get_process(name):
    for p in psutil.process_iter(['name']):
        if p.info['name'] == name:
            return p
    return None

# Wait for the process to actually start (in case it hasn't yet)
print(f"Waiting for {process_name} to start...")
p = get_process(process_name)
while p is None:
    time.sleep(3)
    p = get_process(process_name)

print(f"{process_name} detected! Monitoring CPU...")

# Wait for it to go idle
idle_seconds = 0
while idle_seconds < idle_duration:
    cpu = p.cpu_percent(interval=1)
    if cpu < idle_threshold:
        idle_seconds += 1
        print(f"Idle for {idle_seconds}s...")
    else:
        idle_seconds = 0  # Reset if it becomes active again
    time.sleep(1)

print("App has been idle! Running scripts...")

import os

# This gets the folder where your current script lives
base_dir = os.path.dirname(os.path.abspath(__file__))

subprocess.run(["python", os.path.join(base_dir, "Soundtrap_batch.py")], check=True)
subprocess.run(["python", os.path.join(base_dir, "Soundtrap_summary.py")], check=True)

print("All done!")
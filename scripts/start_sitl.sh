#!/usr/bin/env bash
# Start ArduPilot SITL for testing without real drone
# Requires: ArduPilot installed (see docs/specs/hardware_setup.md)
set -e

SIM_VEHICLE=${SIM_VEHICLE:-"ArduCopter"}
LAT=${LAT:-21.0285}  # Hanoi default
LON=${LON:-105.8542}

echo "🚁 Starting ArduPilot SITL..."
echo "Vehicle: $SIM_VEHICLE"
echo "Location: $LAT, $LON"

sim_vehicle.py \
  -v "$SIM_VEHICLE" \
  --out udp:127.0.0.1:14550 \
  --out udp:127.0.0.1:14551 \
  --map --console \
  -L "Home:$LAT:$LON:0:0"

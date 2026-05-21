#!/bin/bash
# setup.sh - One-command setup for Resume Screening System

set -e

echo "========================================"
echo "  ResumeIQ - Resume Screening System"
echo "  Setup Script"
echo "========================================"

# ── Check Python ──────────────────────────
if ! command -v python3 &>/dev/null; then
  echo "❌ Python 3 is required. Install from https://python.org"
  exit 1
fi

# ── Check Node ────────────────────────────
if ! command -v node &>/dev/null; then
  echo "❌ Node.js is required. Install from https://nodejs.org"
  exit 1
fi

echo ""
echo "✅ Python: $(python3 --version)"
echo "✅ Node:   $(node --version)"
echo ""

# ── Backend ───────────────────────────────
echo "[1/3] Installing Python dependencies..."
cd backend
pip install -r requirements.txt -q
cd ..

# ── Frontend ──────────────────────────────
echo "[2/3] Installing Node dependencies..."
cd frontend
npm install --silent
cd ..

# ── Dataset check ─────────────────────────
echo "[3/3] Checking dataset..."
if [ ! -f "data/UpdatedResumeDataSet.csv" ]; then
  echo ""
  echo "⚠️  Dataset not found at data/UpdatedResumeDataSet.csv"
  echo ""
  echo "   Download from Kaggle:"
  echo "   https://www.kaggle.com/datasets/gauravduttakiit/resume-dataset"
  echo ""
  echo "   The app will run in DEMO MODE (keyword-based) without the dataset."
  echo "   Demo mode is fully functional for testing the interface."
else
  echo ""
  echo "✅ Dataset found! Training models..."
  python3 backend/train.py
fi

echo ""
echo "========================================"
echo "  Setup Complete!"
echo "========================================"
echo ""
echo "  To start the application:"
echo ""
echo "  Terminal 1 (Backend):"
echo "    cd backend && uvicorn main:app --reload"
echo ""
echo "  Terminal 2 (Frontend):"
echo "    cd frontend && npm run dev"
echo ""
echo "  Then open: http://localhost:3000"
echo ""

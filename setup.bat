@echo off
echo ========================================
echo   ResumeIQ - Resume Screening System
echo   Setup Script (Windows)
echo ========================================

echo.
echo [1/3] Installing Python dependencies...
cd backend
pip install -r requirements.txt
cd ..

echo.
echo [2/3] Installing Node dependencies...
cd frontend
npm install
cd ..

echo.
echo [3/3] Checking dataset...
if exist "data\UpdatedResumeDataSet.csv" (
    echo Dataset found! Training models...
    python backend\train.py
) else (
    echo WARNING: Dataset not found at data\UpdatedResumeDataSet.csv
    echo.
    echo Download from: https://www.kaggle.com/datasets/gauravduttakiit/resume-dataset
    echo App will run in DEMO MODE without dataset.
)

echo.
echo ========================================
echo   Setup Complete!
echo ========================================
echo.
echo   Start Backend:  cd backend ^&^& uvicorn main:app --reload
echo   Start Frontend: cd frontend ^&^& npm run dev
echo.
echo   Open: http://localhost:3000
pause

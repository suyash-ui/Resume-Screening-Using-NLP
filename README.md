# ResumeIQ — NLP-Based Resume Screening System

> **Suyash project resume screening using nlp** | Automated Resume Classification using TF-IDF + SVC

A full-stack application that automatically classifies resumes into 25 professional job categories using Natural Language Processing and supervised Machine Learning.

---

## 📁 Project Structure

```
resume-screener/
├── backend/
│   ├── main.py              # FastAPI application (REST API)
│   ├── train.py             # ML training pipeline
│   └── requirements.txt     # Python dependencies
│
├── frontend/
│   ├── src/
│   │   ├── App.jsx          # Main React component
│   │   ├── main.jsx         # React entry point
│   │   └── index.css        # Global styles
│   ├── index.html
│   ├── package.json
│   └── vite.config.js
│
├── models/                  # Auto-created after training
│   ├── tfidf.pkl            # Fitted TF-IDF vectorizer
│   ├── clf.pkl              # Trained SVC classifier
│   ├── encoder.pkl          # Label encoder (25 categories)
│   └── results.pkl          # Benchmark results
│
├── data/
│   └── UpdatedResumeDataSet.csv   # ← Place dataset here
│
└── README.md
```

---

## 🚀 Quick Start

### Prerequisites
- Python 3.9+
- Node.js 18+
- npm or yarn

---

### Step 1: Backend Setup

```bash
cd backend
pip install -r requirements.txt
```

### Step 2: Download Dataset

Download the resume dataset from Kaggle:
```
https://www.kaggle.com/datasets/gauravduttakiit/resume-dataset
```
Place `UpdatedResumeDataSet.csv` in the `data/` directory.

### Step 3: Train Models

```bash
cd backend
python train.py
```

This will:
- Load and explore the dataset (962 samples, 25 categories)
- Balance classes via oversampling → 2,100 samples
- Clean resume text using regex pipeline
- Encode labels with LabelEncoder
- Extract features with TF-IDF (7,353 terms)
- Train 5 classifiers: SVC, KNN, Random Forest, Logistic Regression, Naive Bayes
- Save best model (SVC) to `models/`
- Generate accuracy comparison and confusion matrix plots

### Step 4: Start the Backend API

```bash
cd backend
uvicorn main:app --reload --port 8000
```

API docs available at: http://localhost:8000/docs

### Step 5: Start the Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend available at: http://localhost:3000

---

## 🧠 ML Pipeline

```
Input Resume Text
       ↓
  Text Cleaning (Regex)
  • Remove URLs, hashtags, @mentions
  • Remove non-ASCII characters
  • Normalize whitespace
       ↓
  TF-IDF Vectorization
  • stop_words='english'
  • 7,353 unique vocabulary terms
  • Sparse matrix: N × 7,353
       ↓
  OneVsRest(SVC)
  • 25 binary classifiers
  • Linear kernel
  • Probability calibration
       ↓
  Label Decoding → Category Name
```

---

## 📊 Model Performance

| Model                | Accuracy | Precision | Recall | F1-Score |
|----------------------|----------|-----------|--------|----------|
| KNN (OneVsRest)      | 100.00%  | 1.00      | 1.00   | 1.00     |
| **SVC (OneVsRest)**  | **100.00%** | **1.00** | **1.00** | **1.00** |
| Random Forest        | 100.00%  | 1.00      | 1.00   | 1.00     |
| Logistic Regression  | 96.67%   | 0.97      | 0.96   | 0.97     |
| Gaussian Naive Bayes | ~92.33%  | 0.93      | 0.91   | 0.92     |

---

## 🏷️ 25 Job Categories

| # | Category | # | Category |
|---|----------|---|----------|
| 1 | Data Science | 14 | Health and Fitness |
| 2 | Java Developer | 15 | PMO |
| 3 | Python Developer | 16 | Electrical Engineering |
| 4 | Web Designing | 17 | Business Analyst |
| 5 | HR | 18 | DotNet Developer |
| 6 | Testing | 19 | Automation Testing |
| 7 | DevOps Engineer | 20 | Network Security Engineer |
| 8 | Hadoop | 21 | Civil Engineer |
| 9 | Sales | 22 | SAP Developer |
| 10 | Mechanical Engineer | 23 | Advocate |
| 11 | ETL Developer | 24 | Blockchain |
| 12 | Arts | 25 | Operations Manager |
| 13 | Database | | |

---

## 🌐 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | API info |
| GET | `/health` | Health check + model status |
| GET | `/categories` | List all 25 categories |
| POST | `/predict/text` | Predict from raw text |
| POST | `/predict/file` | Predict from PDF/DOCX/TXT upload |
| POST | `/train` | Trigger model retraining |
| POST | `/clean` | Preview cleaned text |

### Example Request

```bash
curl -X POST http://localhost:8000/predict/text \
  -H "Content-Type: application/json" \
  -d '{"text": "Experienced Python developer with 4 years in Django, FastAPI, ML pipelines..."}'
```

### Example Response

```json
{
  "category": "Python Developer",
  "confidence": 0.921,
  "mode": "ml",
  "top_predictions": [
    {"category": "Python Developer", "score": 0.921},
    {"category": "Data Science", "score": 0.063},
    {"category": "Web Designing", "score": 0.016}
  ],
  "word_count": 245,
  "char_count": 1532
}
```

---

## 🔧 Technology Stack

| Layer | Technology | Version | Purpose |
|-------|-----------|---------|---------|
| **Backend** | FastAPI | 0.110 | REST API framework |
| | uvicorn | 0.27 | ASGI server |
| | scikit-learn | 1.4 | ML models, TF-IDF |
| | pandas | 2.2 | Data manipulation |
| | numpy | 1.26 | Numerical ops |
| | pickle | built-in | Model serialization |
| | PyPDF2 | 3.0 | PDF text extraction |
| | docx2txt | 0.8 | DOCX text extraction |
| **Frontend** | React | 18.2 | UI framework |
| | Vite | 5.0 | Build tool |
| | axios | 1.6 | HTTP client |

---

## 🔮 Future Enhancements

1. **BERT Embeddings** — Replace TF-IDF with contextual transformer embeddings
2. **NER Pipeline** — Extract structured entities (skills, education, experience)
3. **Multi-label Classification** — Support resumes spanning multiple roles
4. **ATS Integration** — REST API adapters for applicant tracking systems
5. **Bias Detection** — Fairness metrics and de-biasing techniques
6. **Multilingual Support** — Process resumes in regional languages
7. **Resume Scoring** — Rank candidates within a category by skill match
8. **Cloud Deployment** — Docker + Kubernetes deployment on AWS/GCP

---

## 👨‍💻 Author

**Suyash** | Project  
NLP & Machine Learning based Resume Screening System

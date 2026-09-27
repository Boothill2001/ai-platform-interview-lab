# Interview guide — AI Platform Engineer / Solution Engineer

## How we work through it

Answer **one question at a time** in chat. Use your own words; do not memorize polished claims. I score each answer 0–4:

- **0:** missing or fundamentally incorrect.
- **1:** names tools/terms without a sound explanation.
- **2:** core is mostly right; an important assumption or link is missing.
- **3:** clear, technically sound, tied to the demo and trade-offs.
- **4:** also gives evidence, failure modes, measurement, and alternatives.

For experience claims, use this frame: **context → your role → decision → implementation → evidence → trade-off/lesson**. Say “I” only for work you personally did; label team work and proposed migration architecture accurately.

## Top 30 — ranked by interview value

### A. Product and architecture

1. Pick one real user from this platform. What recurring decision are they making, what does it cost today, and what measurable result would make the AI solution worth adopting?
2. Walk through one prediction/event from source to user action. At each boundary, what schema, owner, SLO and failure behavior exist?
3. The brief says Kafka handles 9,000 msg/s. Define precisely what was measured: payload size, partition count, producer/consumer setup, duration, p50/p95/p99 latency, error rate, and whether inference was included.
4. Draw the online path and explain why each component is Kafka, a stream processor, FastAPI, PostgreSQL, Redis or a model server. What would you remove first for a smaller workload?
5. Compare the business impact of a false positive and false negative for churn, anomaly detection, recommendations and intent routing. Why should they not share one threshold/metric?

### B. Data, SQL, ETL and feature engineering

6. For the 50M+ record PySpark ETL, describe input grain, primary key, deduplication, late data, partition strategy, skew, shuffle and output contract.
7. Explain a SQL window function and CTE you used or would use for a time-safe customer feature. Write the logic verbally and identify the leakage trap.
8. Design data-quality gates for nulls, duplicates, invalid categories, freshness, volume anomalies and referential integrity. Which failures stop the pipeline; which quarantine rows?
9. How do you make a feature computed in training reproducible in online inference? Explain point-in-time correctness, feature parity, freshness and backfill.
10. A churn model uses “number of support calls in next 30 days.” Why is this leakage? Define prediction timestamp, feature window, label window and split.

### C. Modeling and evaluation

11. The CV says churn AUC 0.87. What does AUC mean, what does it not tell you, and what evidence would you need before claiming business impact?
12. For a 5% churn base rate, why can accuracy mislead? Choose a threshold using business cost, capacity and calibration.
13. Explain XGBoost recommendation + FAISS retrieval as a two-stage system: candidate generation, ranking, offline metrics and online experiment.
14. For Isolation Forest with “94% detection rate,” what is the denominator and ground truth? How would you report precision, recall, alert volume and analyst burden?
15. How do you evaluate BERT intent/entity extraction when classes are imbalanced and intents evolve? Include entity-level scoring, confusion analysis, abstention and fallback.

### D. MLOps and release safety

16. Walk through MLflow Registry `Staging → Production → Archived`. What evidence and approval does each transition require? What metadata must travel with a model?
17. Design CI, CT and CD for ML. Which checks run on code, data, model quality, security and serving image?
18. The demo routes 10% traffic to a canary. Define comparison cohort, minimum sample/time, metrics, guardrail thresholds, sequential testing risks and rollback action.
19. A canary improves AUC but doubles p99 latency and error rate rises. What do you do, and why?
20. Explain model/data/label drift and PSI. Why is “PSI > 0.2 → retrain” an alert heuristic, not a sufficient retraining policy?
21. Describe rollback when an artifact is bad, API schema changed, feature service is stale, or database migration is incompatible. Which rollback is safe and why?

### E. GCP transfer and infrastructure

22. Map Kafka to Pub/Sub, MLflow artifacts to Cloud Storage, batch SQL to BigQuery, training orchestration to Vertex AI Pipelines, and serving to Cloud Run/GKE. What is equivalent and what is not?
23. For Cloud Run vs GKE inference, compare scale-to-zero, startup/cold starts, GPU/custom runtime, concurrency, networking, operations and cost. What workload tips the choice?
24. How would you migrate without a risky cutover? Include dual-write/read, event identity/order, replay, shadow traffic, reconciliation, canary and rollback.
25. How do IAM least privilege, secrets, encryption, private networking, PII minimization, retention and audit logs fit this platform?

### F. Customer-facing and leadership

26. An Australian founder says “we need AI to reduce churn.” What discovery questions clarify user, workflow, baseline, data rights, constraints, success metric and adoption?
27. How would you demo a capability without implying that simulated or offline results are production proof? What follow-up artifact do you leave the customer?
28. Tell the story of proposing an AI use case that expanded project scope. How did you validate value, estimate effort/risk and avoid selling a solution before discovery?
29. You led 3 AI Engineers. How did you make architecture decisions, review code, mentor, handle disagreement and keep delivery quality high? Give a concrete example and outcome.
30. A production assistant gives a harmful/wrong answer, drift alert fires and customer leadership wants an immediate fix. What is your incident response, communication, mitigation and postmortem plan?

## Suggested answer template

```text
Situation / user:
Decision or failure mode:
My role vs team role:
Design and why:
How we measured it:
Result / evidence:
Trade-off, risk, or what I would change:
```

## Current checkpoint

Start at **Question 1**. Do not answer all 30 at once. I will track progress in chat, challenge vague claims, and connect each answer to the relevant interactive panel in `index.html`.

# AGENTS.md

## 🎯 Objetivo del proyecto

Este proyecto es una **plataforma de datos en batch** que simula una arquitectura real de Data Engineering moderna.

El objetivo inicial es construir una base sólida para:

- Ingesta de datos desde múltiples fuentes (BBDD, ficheros, APIs simuladas)
- Procesamiento y transformación en capas (tipo Medallion: Bronze / Silver / Gold)
- Aplicación de reglas de calidad de datos
- Almacenamiento analítico (data warehouse tipo Redshift o equivalente local)
- Orquestación de jobs batch

En fases futuras, el sistema evolucionará hacia:
- Data products
- Semantic layer
- Abstracción de métricas empresariales
- Arquitecturas tipo lakehouse
- Experimentación con LLMs aplicados a datos

---

## 🧠 Filosofía del proyecto

- Priorizar **claridad sobre complejidad**
- Construir como si fuera un sistema real en producción, pero sin sobreingeniería
- Todo debe ser **entendible por un mid-level data engineer**
- Diseñar pensando en escalabilidad futura, pero implementar simple hoy

---

## 🏗️ Arquitectura conceptual

El sistema sigue un enfoque tipo Medallion:

### 🥉 Bronze (Raw / Ingesta)
- Datos tal como llegan de la fuente
- Sin transformación significativa
- Persistencia en storage tipo S3 (o local equivalente)

### 🥈 Silver (Procesado / Limpieza)
- Limpieza de datos
- Normalización de esquemas
- Enriquecimiento básico
- Dedupe y calidad de datos

### 🥇 Gold (Modelo analítico)
- Modelos orientados a negocio
- Agregaciones y métricas
- Preparado para consumo (BI / APIs / analytics)

---

## ⚙️ Stack recomendado (flexible)

- Python (obligatorio)
- SQL cuando sea necesario
- AWS conceptual (Glue, S3, Redshift) o simulación local
- dbt (futuro o modular)
- Docker opcional
- LocalStack opcional para emular AWS

---

## 🔁 Flujo de trabajo obligatorio del agente

Siempre seguir este flujo:

1. **Entender el problema**
   - Qué dato entra
   - Qué transformación se necesita
   - En qué capa del sistema vive

2. **Proponer plan antes de tocar código**
   - Arquitectura simple
   - Pasos pequeños
   - Archivos afectados

3. **Implementar en pasos pequeños**
   - Cambios incrementales
   - Un componente por vez

4. **Validar ejecución**
   - Tests o ejecución manual controlada
   - Verificar outputs intermedios

5. **Corregir errores antes de avanzar**
   - No seguir si hay fallos sin resolver

---

## 🚫 Reglas estrictas

- ❌ No hacer refactors masivos
- ❌ No reescribir módulos completos sin necesidad
- ❌ No añadir complejidad futura innecesaria
- ❌ No mezclar capas (Bronze/Silver/Gold deben estar separadas)

---

## ✅ Reglas de trabajo

- ✔️ Trabajar siempre en tareas pequeñas
- ✔️ Mantener el código simple y legible
- ✔️ Priorizar modularidad clara
- ✔️ Separar claramente ingesta, transformación y salida
- ✔️ Validar cada cambio antes de continuar

---

## 📦 Estructura mental del proyecto

El agente debe pensar siempre en:

- **Ingestion layer** → entrada de datos
- **Processing layer** → transformación
- **Storage layer** → persistencia analítica
- **Orchestration layer** → ejecución de pipelines

---

## 🚀 Evolución futura (NO implementar todavía)

Estas ideas están fuera del scope inicial, pero deben guiar el diseño:

- Semantic layer (definición de métricas reutilizables)
- Data contracts entre capas
- Data lineage
- Feature store (si se integra ML)
- LLMs para generación de queries o explicación de datos
- API layer sobre datasets curados

---

## 🧩 Principio clave

> “Primero hacerlo funcionar simple. Luego hacerlo correcto. Luego hacerlo escalable.”

---

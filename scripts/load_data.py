"""
load_data.py

Reusable data-loading utilities for the DataProjects workspace.
Supports CSV, Excel, and JSON files with safe path handling and
clear error messages.

Usage:
    from load_data import load_csv
    df = load_csv("data_raw/myfile.csv")
"""

import os
import pandas as pd


def _validate_path(path: str) -> str:
    """
    Validate that a file exists. Return absolute path.
    Raise FileNotFoundError if missing.
    """
    abs_path = os.path.abspath(path)

    if not os.path.exists(abs_path):
        raise FileNotFoundError(f"File not found: {abs_path}")

    return abs_path


def load_csv(path: str) -> pd.DataFrame:
    """
    Load a CSV file safely.
    """
    abs_path = _validate_path(path)
    return pd.read_csv(abs_path)


def load_excel(path: str) -> pd.DataFrame:
    """
    Load an Excel file safely.
    """
    abs_path = _validate_path(path)
    return pd.read_excel(abs_path)


def load_json(path: str) -> pd.DataFrame:
    """
    Load a JSON file safely.
    """
    abs_path = _validate_path(path)
    return pd.read_json(abs_path)

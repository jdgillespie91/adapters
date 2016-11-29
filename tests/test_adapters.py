from adapters import adapters


def test_placeholder_adapter_exists():
    assert adapters.Placeholder


def test_s3_adapter_adapter_exists():
    assert adapters.S3Adapter

import project_generator


if __name__ == "__main__":
    try:
        project_generator.generate_project()
    except Exception as error_message:
        raise RuntimeError(str(error_message))

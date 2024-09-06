import subprocess

def uninstall_unwanted_packages():
    # List the packages to uninstall
    packages = ['scipy','click','joblib', 'numpy','sklearn','scikit_learn','tqdm','stdnum','threadpoolctl']
    for package in packages:
        try:
            subprocess.check_call(['pip', 'uninstall', '-y', package])
            print(f"Uninstalled {package}")
        except subprocess.CalledProcessError:
            print(f"{package} is not installed or already removed")

if __name__ == "__main__":
    uninstall_unwanted_packages()

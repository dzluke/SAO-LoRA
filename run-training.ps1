# uv run train.py --name blackbird-lora --use-lora true --model-config blackbird-model-config.json --dataset-config blackbird-dataset-config.json --batch-size 1 --checkpoint-every 1 --save-dir finetune --pretrained-ckpt-path stable-audio-open-1.0/model.ckpt  --pretransform-ckpt-path stable-audio-open-1.0/vae_model.ckpt

# $command = "uv run train.py --name blackbird-lora --use-lora true --model-config blackbird-model-config.json --dataset-config blackbird-dataset-config.json --batch-size 4 --checkpoint-every 10000 --save-dir finetune --pretrained-ckpt-path stable-audio-open-1.0/model.ckpt"

# $env:WANDB_API_KEY = "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"

# Start-Process powershell -WorkingDirectory "D:\LukeDzwonczyk\SAO-LoRA" -RedirectStandardOutput "stdout.txt" -RedirectStandardError "stderr.txt" -ArgumentList '-NoProfile', '-Command', $command
# Get-CimInstance Win32_Process | Where-Object { $_.Name -like "*uv*" } | Select-Object ProcessId, Name, CommandLine

$projectDir = "D:\LukeDzwonczyk\SAO-LoRA"

$stdout = Join-Path $projectDir "stdout.txt"
$stderr = Join-Path $projectDir "stderr.txt"

$env:WANDB_API_KEY = "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"

$command = @(
    "run"
    "train.py"
    "--name", "blackbird-lora"
    "--use-lora", "true"
    "--model-config", "lora-model-config.json"
    "--dataset-config", "blackbird-dataset-config.json"
    "--batch-size", "4"
    "--checkpoint-every", "10000"
    "--save-dir", "finetune"
    "--pretrained-ckpt-path", "stable-audio-open-1.0/model.ckpt"
    "--pretransform-ckpt-path", "stable-audio-open-1.0/vae_model.ckpt"
)

$process = Start-Process `
    -FilePath "uv" `
    -ArgumentList $command `
    -WorkingDirectory $projectDir `
    -RedirectStandardOutput $stdout `
    -RedirectStandardError $stderr `
    -PassThru `
    -WindowStyle Hidden

Write-Host "Training started."
Write-Host "PID:" $process.Id
Write-Host "Logs:"
Write-Host "  stdout -> $stdout"
Write-Host "  stderr -> $stderr"

Get-CimInstance Win32_Process | Where-Object { $_.Name -like "*python*" } | Select-Object ProcessId, Name, CommandLine
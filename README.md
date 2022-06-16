# High Performance Computing
The crucial point in *High Performance Parallel Programming* is to understand which part of the code should use CPU and which will benefit from the execution on a GPU. 

## CPU vs GPU
| CPU | GPU |
| --- | --- |
| Latency oriented device | Throughput oriented device |
| ALUs are powerful but small in number | ALUs are Efficient but large in number |
| Large Cache | Small Cache |
| Sophisticated control unit | Simple control unit |

> CPUs are effective for sequential parts of a program while GPUs thrive on parallel parts.
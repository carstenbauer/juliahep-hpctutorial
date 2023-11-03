using Pkg
println("\n\n\tActivating environment in $(pwd())...")
pkg"activate ."
println("\n\n\tInstantiating environment... (i.e. downloading + installing + precompiling packages)");
flush(stdout);
pkg"instantiate"
pkg"precompile"

println("\n\n\tLoading CUDA (to trigger lazy artifact downloads) ...");
flush(stdout);
using CUDA
CUDA.precompile_runtime()
if CUDA.functional()
    CUDA.versioninfo()
end
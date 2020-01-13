sizes_from_blocks(A::AbstractVector, ::Tuple{OneToInf{Int}}) = (map(length,A),)



MemoryLayout(::Type{<:PseudoBlockArray{<:Any,N,<:Arr}}) where {N,Arr} = 
    MemoryLayout(Arr)

struct BlockLayout{LAY} <: MemoryLayout end

MemoryLayout(::Type{<:BlockArray{<:Any,N,<:Arr}}) where {N,Arr} = 
    blocklayout(MemoryLayout(Arr))

blocklayout(_) = BlockLayout{UnknownLayout}()    
blocklayout(::LazyLayout) = BlockLayout{LazyLayout}()    

# for LazyLay in (:(BlockLayout{LazyLayout}), :(TriangularLayout{UPLO,UNIT,BlockLayout{LazyLayout}} where {UPLO,UNIT}))
#     @eval begin
#         combine_mul_styles(::$LazyLay) = LazyArrayApplyStyle()
#         mulapplystyle(::QLayout, ::$LazyLay) = LazyArrayApplyStyle()
#     end
# end

# BlockArrays.blockbroadcaststyle(::LazyArrayStyle{N}) where N = LazyArrayStyle{N}()


include("infblocktridiagonal.jl")

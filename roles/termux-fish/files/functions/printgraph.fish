function printgraph
    dot -OTsvg $args; and feh --magic-timeout 1 $args.dot
end


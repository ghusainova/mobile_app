String truncateWithEllipsis({required String text, int cutoff = 10}) =>
    (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
